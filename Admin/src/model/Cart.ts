class Cart {
    public customerId: number;
    public productId: number;
    public amount: number;
    public colorId: number;

    public constructor(customerId: number, productId: number, amount: number, colorId: number) {
        this.customerId = customerId;
        this.productId = productId;
        this.amount = amount;
        this.colorId = colorId;
    }
}

export default Cart;
