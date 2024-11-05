class Account {
    public customerId: number;
    public accCustomerId: string;
    public email: string;

    public constructor(customerId: number, accCustomerId: string, email: string) {
        this.customerId = customerId;
        this.accCustomerId = accCustomerId;
        this.email = email;
    }
}

export default Account;
