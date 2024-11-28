import { Admin } from 'react-admin';
import simpleRestProvider from 'ra-data-simple-rest';

function App() {
    return <Admin dataProvider={simpleRestProvider('http://dangvankhanhblog.io.vn:7138')}></Admin>;
}

export default App;
