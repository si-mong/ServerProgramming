package com.restaurant.controller;

import com.restaurant.model.Menu;
import com.restaurant.model.Order;
import com.restaurant.model.Table;
import com.restaurant.service.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
// 관리자 페이지
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private StorageService storageService;

    // 관리자-메뉴 관리
    @RequestMapping("/menu.html")
    public String menu(@RequestParam String action,
                      @RequestParam(required = false) String name,
                      @RequestParam(required = false) Integer price,
                      Model model,
                      HttpServletResponse response) throws IOException {
        
        List<Menu> menus = storageService.getMenus();
        
        if ("add".equals(action)) {
            // 가격 정보가 없으면 0으로 처리 (NPE 방지)
            if (price == null) price = 0;

            // 이미 존재하는 메뉴인지 확인
            boolean exists = menus.stream().anyMatch(m -> m.getName().equals(name));
            if (exists) {
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("menu add error");
                return null;
            }
            
            menus.add(new Menu(name, price));
            storageService.saveMenus(menus);
            
        } else if ("del".equals(action)) {
            // 메뉴가 존재하는지 확인
            boolean exists = menus.removeIf(m -> m.getName().equals(name));
            if (!exists) {
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("menu del error");
                return null;
            }
            
            storageService.saveMenus(menus);
        }
        
        // stat 또는 작업 완료 후 현재 메뉴 목록 표시
        model.addAttribute("menus", storageService.getMenus());
        return "admin/menu-stat";
    }

    // 관리자-테이블 관리
    @RequestMapping("/table.html")
    public String table(@RequestParam String action,
                       @RequestParam(required = false) String tid,
                       Model model,
                       HttpServletResponse response) throws IOException {
        
        List<Table> tables = storageService.getTables();
        Map<String, Order> orders = storageService.getOrders();
        
        if ("add".equals(action)) {
            // 이미 존재하는 테이블인지 확인
            boolean exists = tables.stream().anyMatch(t -> t.getTid().equals(tid));
            if (exists) {
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("table add error");
                return null;
            }
            
            tables.add(new Table(tid));
            storageService.saveTables(tables);
            
        } else if ("del".equals(action)) {
            // 테이블이 존재하는지 확인
            boolean exists = tables.stream().anyMatch(t -> t.getTid().equals(tid));
            if (!exists) {
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("table del error");
                return null;
            }
            
            // 계산이 완료되지 않은 테이블인지 확인
            Order order = orders.get(tid);
            if (order != null && !order.getItems().isEmpty()) {
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("table del error2");
                return null;
            }
            
            tables.removeIf(t -> t.getTid().equals(tid));
            orders.remove(tid);
            storageService.saveTables(tables);
            storageService.saveOrders(orders);
        }
        
        // stat 또는 작업 완료 후 현재 테이블 목록 표시
        model.addAttribute("tables", storageService.getTables());
        return "admin/table-stat";
    }

    // 관리자-전체 현황 확인
    @RequestMapping("/status.html")
    public String status(Model model) {
        List<Table> tables = storageService.getTables();
        Map<String, Order> orders = storageService.getOrders();
        List<Menu> menus = storageService.getMenus();
        
        model.addAttribute("tables", tables);
        model.addAttribute("orders", orders);
        model.addAttribute("menus", menus);
        
        return "admin/status";
    }

    // 관리자-계산 처리
    @RequestMapping("/checkout.html")
    public String checkout(@RequestParam String tid, 
                          Model model,
                          HttpServletResponse response) throws IOException {
        List<Table> tables = storageService.getTables();
        Map<String, Order> orders = storageService.getOrders();
        
        // 테이블이 존재하는지 확인
        boolean exists = tables.stream().anyMatch(t -> t.getTid().equals(tid));
        if (!exists) {
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write("table checkout error");
            return null;
        }
        
        // 해당 테이블의 주문 삭제 (계산 완료)
        orders.remove(tid);
        storageService.saveOrders(orders);
        
        // 현황 화면으로 이동
        model.addAttribute("tables", tables);
        model.addAttribute("orders", orders);
        model.addAttribute("menus", storageService.getMenus());
        
        return "admin/status";
    }
}
