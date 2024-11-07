import Address from './Address';

class CustomerInfo {
    public customerId: number;
    public fullName: string;
    public phoneNumber: string;
    public address: Address;

    public constructor(
        customerId: number,
        fullName: string,
        phoneNumber: string,
        address: Address,
    ) {
        this.customerId = customerId;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.address = address;
    }
}

export default CustomerInfo;
