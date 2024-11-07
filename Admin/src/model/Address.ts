class Address {
    public addressId: number;
    public province: string;
    public district: string;
    public commune: string;
    public street: string;
    public numberHouse: string;

    public constructor(
        addressId: number,
        province: string,
        district: string,
        commune: string,
        street: string,
        numberHouse: string,
    ) {
        this.addressId = addressId;
        this.province = province;
        this.district = district;
        this.street = street;
        this.commune = commune;
        this.numberHouse = numberHouse;
    }
}

export default Address;
