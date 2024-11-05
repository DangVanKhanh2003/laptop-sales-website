class Category {
    public categoryId: number;
    public categoryName: string;
    public categoryIcon: string;
    public constructor(categoryId: number, categoryName: string, categoryIcon: string) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.categoryIcon = categoryIcon;
    }
}

export default Category;
