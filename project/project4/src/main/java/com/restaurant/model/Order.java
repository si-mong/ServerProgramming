package com.restaurant.model;

import java.util.ArrayList;
import java.util.List;

public class Order {
    private List<OrderItem> items;
    private boolean finished;

    public Order() {
        this.items = new ArrayList<>();
        this.finished = false;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }

    public boolean isFinished() {
        return finished;
    }

    public void setFinished(boolean finished) {
        this.finished = finished;
    }

    public int getTotal() {
        return items.stream()
                .mapToInt(OrderItem::getTotal)
                .sum();
    }
}



