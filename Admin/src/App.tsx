import { useState } from 'react';
import TopAppBar from './components/Appbar/Appbar';
import LeftDrawer from './components/Drawer/Drawer';
import { Navigate, Route, Routes } from 'react-router-dom';
import Home from './components/Home/Home';
import Dashboard from './components/Dashboard/Dashboard';
import ManageProduct from './components/Admin/Product/ManageProduct';
import ManageSale from './components/Admin/Sale/ManageSale';
import ManageAccount from './components/Admin/Account/ManageAccount';
import ManageStore from './components/Admin/Store/ManageStore';
import ManageOrder from './components/Admin/Order/ManageOrder';
import ManageCategory from './components/Admin/Category/ManageCategory';

function App() {
    const [open, setOpen] = useState<boolean>(false);

    const toggleDrawer = (newOpen: boolean) => {
        setOpen(newOpen);
    };

    return (
        <>
            <TopAppBar toggleDrawer={toggleDrawer} />
            <LeftDrawer open={open} toggleDrawer={toggleDrawer} />
            <Routes>
                <Route path='/' element={<Navigate to='/home' />} />
                {/** First section start */}
                <Route path='/home' element={<Home />} />
                <Route path='/dashboard' element={<Dashboard />} />
                {/** Second section start */}
                <Route path='/admin/product' element={<ManageProduct />} />
                <Route path='/admin/sale' element={<ManageSale />} />
                <Route path='/admin/account' element={<ManageAccount />} />
                <Route path='/admin/store' element={<ManageStore />} />
                <Route path='/admin/order' element={<ManageOrder />} />
                <Route path='/admin/category' element={<ManageCategory />} />
            </Routes>
        </>
    );
}

export default App;
