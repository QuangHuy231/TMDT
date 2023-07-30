import axios from "axios";
import { useEffect } from "react";
import { createContext, useState } from "react";
import { useLocation } from "react-router-dom";

export const Context = createContext();

const AppContext = ({ children }) => {
  const [user, setUser] = useState(
    JSON.parse(localStorage.getItem("user")) || null
  );
  const [categories, setCategories] = useState([]);
  const [products, setProducts] = useState([]);
  const [showCart, setShowCart] = useState(false);
  const [cartItems, setCartItems] = useState([]);
  const [cartCount, setCartCount] = useState(0);
  const [cartSubTotal, setCartSubTotal] = useState(0);

  const [filterCategories, setFilterCategories] = useState(["All"]);
  const [filterProducts, setFilterProducts] = useState([]);
  const [minPrice, setMinPrice] = useState(0);
  const [maxPrice, setMaxPrice] = useState(100);

  const [results, setResults] = useState([]);
  const handleMinPriceChange = (e) => {
    setMinPrice(e.target.value);
  };

  const handleMaxPriceChange = (e) => {
    setMaxPrice(e.target.value);
  };

  // Xử lý khi nhấp vào nút lọc
  const handleFilterClick = (listProducts) => {
    const filteredProducts = listProducts
      .filter((product) => {
        // Kiểm tra category
        if (filterCategories == "All") {
          return true; // Nếu categoryFilter là 'all' thì giữ lại tất cả sản phẩm
        } else {
          return product.category_name.includes(filterCategories); // Nếu không, chỉ giữ lại sản phẩm có category trùng khớp
        }
      })
      .filter((product) => {
        // Kiểm tra price
        if (minPrice === "" && maxPrice === "") {
          return true; // Nếu không có minPrice và maxPrice thì giữ lại tất cả sản phẩm
        } else {
          const price = product.old_price;
          const min = parseInt(minPrice);
          const max = parseInt(maxPrice);
          return (
            (minPrice === "" || price >= min) &&
            (maxPrice === "" || price <= max)
          ); // Giữ lại sản phẩm nếu giá nằm trong khoảng min và max
        }
      });

    setFilterProducts(filteredProducts);
  };
  const handleCategoryChange = (e) => {
    const selectedCategories = Array.from(
      e.target.selectedOptions,
      (option) => option.value
    );

    setFilterCategories(selectedCategories);
  };

  const fetchSearch = async (value) => {
    var categoryArray;
    categoryArray = await axios.get("/product/get-products").then((res) => {
      return res.data;
    });

    const results = categoryArray.filter((product) => {
      return (
        value &&
        product &&
        product.product_name &&
        product.product_name.toLowerCase().includes(value)
      );
    });
    setResults(results);
  };

  const location = useLocation();

  useEffect(() => {
    window.scrollTo(0, 0);
  }, [location]);

  useEffect(() => {
    axios.get("/product/get-products").then((res) => {
      setProducts(res.data);
    });
  }, []);

  useEffect(() => {
    axios.get("/category/get-categories").then((res) => {
      setCategories(res.data);
    });
  }, []);

  useEffect(() => {
    let count = 0;
    cartItems?.map((item) => (count += item.attributes.quantity));
    setCartCount(count);

    let subTotal = 0;
    cartItems.map(
      (item) => (subTotal += item.attributes.price * item.attributes.quantity)
    );
    setCartSubTotal(subTotal);
  }, [cartItems]);

  const handleAddToCart = (product, quantity) => {
    let items = [...cartItems];
    let index = items?.findIndex((p) => p.id === product?.id);
    if (index !== -1) {
      items[index].attributes.quantity += quantity;
    } else {
      product.attributes.quantity = quantity;
      items = [...items, product];
    }
    setCartItems(items);
  };

  const handleRemoveFromCart = (product) => {
    let items = [...cartItems];
    items = items?.filter((p) => p.id !== product?.id);
    setCartItems(items);
  };

  const handleCartProductQuantity = (type, product) => {
    let items = [...cartItems];
    let index = items?.findIndex((p) => p.id === product?.id);
    if (type === "inc") {
      items[index].attributes.quantity += 1;
    } else if (type === "dec") {
      if (items[index].attributes.quantity === 1) return;
      items[index].attributes.quantity -= 1;
    }
    setCartItems(items);
  };

  return (
    <Context.Provider
      value={{
        products,
        setProducts,
        categories,
        setCategories,
        cartItems,
        setCartItems,
        handleAddToCart,
        cartCount,
        handleRemoveFromCart,
        showCart,
        setShowCart,
        handleCartProductQuantity,
        cartSubTotal,
        user,
        setUser,
        handleMaxPriceChange,
        maxPrice,
        minPrice,
        handleMinPriceChange,
        handleFilterClick,
        setFilterCategories,
        filterCategories,
        handleCategoryChange,
        filterProducts,
        fetchSearch,
        results,
        setMaxPrice,
        setMinPrice,
      }}
    >
      {children}
    </Context.Provider>
  );
};

export default AppContext;
