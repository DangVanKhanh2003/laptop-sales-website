class Sale {
    public saleId: number;
    public productId: number;
    public numProduct: number;
    public startAt: string;
    public endAt: string;
    public percentSale: number;
    public numProductSold: number;

    public constructor(
        saleId: number,
        productId: number,
        numProduct: number,
        startAt: string,
        endAt: string,
        percentSale: number,
        numProductSold: number,
    ) {
        this.saleId = saleId;
        this.productId = productId;
        this.numProduct = numProduct;
        this.startAt = startAt;
        this.endAt = endAt;
        this.percentSale = percentSale;
        this.numProductSold = numProductSold;
    }
}

export default Sale;
