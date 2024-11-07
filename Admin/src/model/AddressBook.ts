class AddressBook {
    public province: string;
    public district: string;
    public commune: string;
    public street: string;
    public numberHouse: string;
    public phoneNumber: string;
    public customerId: number;

    public constructor(
        province: string,
        district: string,
        commune: string,
        street: string,
        numberHouse: string,
        phoneNumber: string,
        customerId: number,
    ) {
        this.province = province;
        this.district = district;
        this.commune = commune;
        this.street = street;
        this.numberHouse = numberHouse;
        this.phoneNumber = phoneNumber;
        this.customerId = customerId;
    }
}

export default AddressBook;
