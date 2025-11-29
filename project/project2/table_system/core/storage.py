# table_system/core/storage.py
# 새로 추가
# 파일로 메뉴/테이블 저장

# core/storage.py
import json, os, threading, tempfile
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent  # table_system/
DATA_DIR = BASE_DIR / 'data'
DATA_DIR.mkdir(exist_ok=True)

MENU_FILE = DATA_DIR / 'menus.json'
TABLE_FILE = DATA_DIR / 'tables.json'

# --- 캐시 & 락 ---
_lock = threading.RLock()
_menu_cache = None
_menu_mtime = 0.0
_table_cache = None
_table_mtime = 0.0

def _safe_read(path: Path, default):
    if not path.exists():
        return default
    with path.open('r', encoding='utf-8') as f:
        return json.load(f)

def _atomic_write(path: Path, obj):
    # tmp 파일에 쓰고 rename으로 교체(원자적)
    tmp_fd, tmp_path = tempfile.mkstemp(dir=str(path.parent), prefix=path.name, text=True)
    try:
        with os.fdopen(tmp_fd, 'w', encoding='utf-8') as f:
            json.dump(obj, f, ensure_ascii=False, indent=2)
        os.replace(tmp_path, path)  # 원자적 교체
    finally:
        try:
            if os.path.exists(tmp_path):
                os.remove(tmp_path)
        except OSError:
            pass

def load_menus():
    global _menu_cache, _menu_mtime
    with _lock:
        mtime = MENU_FILE.stat().st_mtime if MENU_FILE.exists() else 0.0
        if _menu_cache is not None and mtime == _menu_mtime:
            return _menu_cache
        data = _safe_read(MENU_FILE, [])
        _menu_cache = data
        _menu_mtime = mtime
        return data

def save_menus(menus):
    global _menu_cache, _menu_mtime
    with _lock:
        _atomic_write(MENU_FILE, menus)
        _menu_cache = menus
        _menu_mtime = MENU_FILE.stat().st_mtime if MENU_FILE.exists() else 0.0

def load_tables():
    global _table_cache, _table_mtime
    with _lock:
        mtime = TABLE_FILE.stat().st_mtime if TABLE_FILE.exists() else 0.0
        if _table_cache is not None and mtime == _table_mtime:
            return _table_cache
        data = _safe_read(TABLE_FILE, {})
        _table_cache = data
        _table_mtime = mtime
        return data

def save_tables(tables):
    global _table_cache, _table_mtime
    with _lock:
        _atomic_write(TABLE_FILE, tables)
        _table_cache = tables
        _table_mtime = TABLE_FILE.stat().st_mtime if TABLE_FILE.exists() else 0.0