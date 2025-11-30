package com.restaurant.model;

public class OrderItem {
    private String menu;
    private int num;
    private int price;

    public OrderItem() {}

    public OrderItem(String menu, int num, int price) {
        this.menu = menu;
        this.num = num;
        this.price = price;
    }

    public String getMenu() {
        return menu;
    }

    public void setMenu(String menu) {
        this.menu = menu;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getTotal() {
        return price * num;
    }
}



