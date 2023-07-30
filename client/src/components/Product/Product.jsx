import React from "react";
import "./Product.scss";
import { Link } from "react-router-dom";
const Product = ({ product, id }) => {
  const { image_url, product_name, old_price, new_price } = product;
  return (
    <div className="product-card">
      <Link className="thumbnail" to={`/product/${id}`}>
        <img src={image_url} alt="product_image" />
      </Link>
      <div className="prod-details">
        <span className="name">{product_name}</span>
        <div className="price-button">
          {new_price ? (
            <div className="price-wrapper">
              <span className="old-price">&#36;{old_price} </span>
              <span className="price">&#36;{new_price}</span>
            </div>
          ) : (
            <div className="price-wrapper">
              <span className="price">&#36;{old_price}</span>
            </div>
          )}
          <button className="add-to-cart">Add to cart</button>
        </div>
      </div>
    </div>
  );
};

export default Product;