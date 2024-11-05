import Sale from './Sale';

class Product {
    public productId: number;
    public productName: string;
    public brand: string;
    public series: string;
    public price: number;
    public categoryName: string;
    public mainImg?: string;
    public sale?: Sale;

    public constructor(
        productId: number,
        productName: string,
        brand: string,
        series: string,
        price: number,
        categoryName: string,
    ) {
        this.productId = productId;
        this.productName = productName;
        this.brand = brand;
        this.series = series;
        this.price = price;
        this.categoryName = categoryName;
    }
}

export default Product;
