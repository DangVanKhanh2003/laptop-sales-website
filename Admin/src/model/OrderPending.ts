class ProductOrderPending {
    public productOrderPendingId: number;
    public productName: string;
    public amount: number;

    public constructor(data: {
        productOrderPendingId: number;
        productName: string;
        amount: number;
    }) {
        this.productOrderPendingId = data.productOrderPendingId;
        this.productName = data.productName;
        this.amount = data.amount;
    }
}

class OrderPending {
    public orderPendingId: number;
    public customerName: string;
    public employeeName: string | null;
    public orderDate: Date;
    public status: string;
    public listProductOrderPending: ProductOrderPending[];

    public constructor(data: {
        orderPendingId: number;
        customerName: string;
        employeeName: string | null;
        orderDate: string;
        status: string;
        listProductOrederPending: {
            productOrderPendingId: number;
            productName: string;
            amount: number;
        }[];
    }) {
        this.orderPendingId = data.orderPendingId;
        this.customerName = data.customerName;
        this.employeeName = data.employeeName;
        this.orderDate = new Date(data.orderDate);
        this.status = data.status;
        this.listProductOrderPending = data.listProductOrederPending.map(
            (product) => new ProductOrderPending(product),
        );
    }
}

export default OrderPending;
