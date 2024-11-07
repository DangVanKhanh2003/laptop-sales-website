import Address from './Address';

class Store {
    public storeId: number;
    public storeName: string;
    public address: Address;

    public constructor(storeId: number, storeName: string, address: Address) {
        this.storeId = storeId;
        this.storeName = storeName;
        this.address = address;
    }
}

export default Store;
