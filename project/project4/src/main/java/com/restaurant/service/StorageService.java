package com.restaurant.service;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.restaurant.model.Menu;
import com.restaurant.model.Order;
import com.restaurant.model.Table;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.io.*;
import java.lang.reflect.Type;
import java.nio.file.*;
import java.util.*;

@Service
public class StorageService {
    private static final String DATA_DIR = "data";
    private static final String MENU_FILE = DATA_DIR + "/menus.json";
    private static final String TABLE_FILE = DATA_DIR + "/tables.json";
    private static final String ORDER_FILE = DATA_DIR + "/orders.json";

    private final Gson gson = new GsonBuilder().setPrettyPrinting().create();

    private List<Menu> menusCache = new ArrayList<>();
    private List<Table> tablesCache = new ArrayList<>();
    private Map<String, Order> ordersCache = new HashMap<>();

    @PostConstruct
    public void init() {
        ensureFiles();
        loadData();
    }

    private void ensureFiles() {
        try {
            Path dataPath = Paths.get(DATA_DIR);
            if (!Files.exists(dataPath)) {
                Files.createDirectories(dataPath);
            }

            if (!Files.exists(Paths.get(MENU_FILE))) {
                Files.write(Paths.get(MENU_FILE), "[]".getBytes());
            }
            if (!Files.exists(Paths.get(TABLE_FILE))) {
                Files.write(Paths.get(TABLE_FILE), "[]".getBytes());
            }
            if (!Files.exists(Paths.get(ORDER_FILE))) {
                Files.write(Paths.get(ORDER_FILE), "{}".getBytes());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void loadData() {
        try {
            String menuJson = new String(Files.readAllBytes(Paths.get(MENU_FILE)));
            Type menuListType = new TypeToken<List<Menu>>(){}.getType();
            menusCache = gson.fromJson(menuJson, menuListType);
            if (menusCache == null) menusCache = new ArrayList<>();

            String tableJson = new String(Files.readAllBytes(Paths.get(TABLE_FILE)));
            Type tableListType = new TypeToken<List<Table>>(){}.getType();
            tablesCache = gson.fromJson(tableJson, tableListType);
            if (tablesCache == null) tablesCache = new ArrayList<>();

            String orderJson = new String(Files.readAllBytes(Paths.get(ORDER_FILE)));
            Type orderMapType = new TypeToken<Map<String, Order>>(){}.getType();
            ordersCache = gson.fromJson(orderJson, orderMapType);
            if (ordersCache == null) ordersCache = new HashMap<>();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Menu operations
    public List<Menu> getMenus() {
        return new ArrayList<>(menusCache);
    }

    public void saveMenus(List<Menu> menus) {
        menusCache = new ArrayList<>(menus);
        saveToFile(MENU_FILE, menus);
    }

    // Table operations
    public List<Table> getTables() {
        return new ArrayList<>(tablesCache);
    }

    public void saveTables(List<Table> tables) {
        tablesCache = new ArrayList<>(tables);
        saveToFile(TABLE_FILE, tables);
    }

    // Order operations
    public Map<String, Order> getOrders() {
        return new HashMap<>(ordersCache);
    }

    public void saveOrders(Map<String, Order> orders) {
        ordersCache = new HashMap<>(orders);
        saveToFile(ORDER_FILE, orders);
    }

    private void saveToFile(String filename, Object data) {
        try {
            String json = gson.toJson(data);
            Files.write(Paths.get(filename), json.getBytes());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}






