package com.restaurant.controller;

import com.restaurant.model.Menu;
import com.restaurant.model.Order;
import com.restaurant.model.OrderItem;
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
import java.util.Optional;

@Controller
// 고객 페이지
@RequestMapping("/customer")
public class CustomerController {

    @Autowired
    private StorageService storageService;

    // 고객-주문 관리
    @RequestMapping("/order.html")
    public String order(@RequestParam String action,
                       @RequestParam String tid,
                       @RequestParam(required = false) String menu,
                       @RequestParam(required = false) Integer num,
                       Model model,
                       HttpServletResponse response) throws IOException {
        
        List<Table> tables = storageService.getTables();
        List<Menu> menus = storageService.getMenus();
        Map<String, Order> orders = storageService.getOrders();
        
        // 테이블이 존재하는지 확인
        boolean tableExists = tables.stream().anyMatch(t -> t.getTid().equals(tid));
        if (!tableExists && !"stat".equals(action)) {
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write("customer order table error");
            return null;
        }
        
        if ("add".equals(action)) {
            // 메뉴가 존재하는지 확인
            Optional<Menu> menuOpt = menus.stream()
                    .filter(m -> m.getName().equals(menu))
                    .findFirst();
            
            if (!menuOpt.isPresent()) {
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("customer order add menu error");
                return null;
            }
            
            Menu foundMenu = menuOpt.get();
            
            // 해당 테이블의 주문 가져오기 (없으면 생성)
            Order order = orders.computeIfAbsent(tid, k -> new Order());
            
            // 동일한 메뉴가 이미 있는지 확인
            Optional<OrderItem> existingItem = order.getItems().stream()
                    .filter(item -> item.getMenu().equals(menu))
                    .findFirst();
            
            if (existingItem.isPresent()) {
                // 기존 항목의 수량 증가
                existingItem.get().setNum(existingItem.get().getNum() + num);
            } else {
                // 새 항목 추가
                order.getItems().add(new OrderItem(menu, num, foundMenu.getPrice()));
            }
            
            orders.put(tid, order);
            storageService.saveOrders(orders);
            
        } else if ("del".equals(action)) {
            // 메뉴가 존재하는지 확인
            boolean menuExists = menus.stream().anyMatch(m -> m.getName().equals(menu));
            if (!menuExists) {
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("customer order del menu error");
                return null;
            }
            
            Order order = orders.get(tid);
            if (order != null) {
                Optional<OrderItem> itemOpt = order.getItems().stream()
                        .filter(item -> item.getMenu().equals(menu))
                        .findFirst();
                
                if (itemOpt.isPresent()) {
                    OrderItem item = itemOpt.get();
                    int newNum = item.getNum() - num;
                    
                    if (newNum <= 0) {
                        // 수량이 0 이하면 항목 삭제
                        order.getItems().remove(item);
                    } else {
                        // 수량 감소
                        item.setNum(newNum);
                    }
                    
                    storageService.saveOrders(orders);
                }
            }
            
        } else if ("finish".equals(action)) {
            // 주문 확정
            Order order = orders.get(tid);
            if (order != null) {
                order.setFinished(true);
                storageService.saveOrders(orders);
            }
        }
        
        // stat 또는 작업 완료 후 해당 테이블의 주문 상태 표시
        Order currentOrder = orders.get(tid);
        if (currentOrder == null) {
            currentOrder = new Order();
        }
        
        model.addAttribute("tid", tid);
        model.addAttribute("order", currentOrder);
        
        return "customer/order-stat";
    }
}
