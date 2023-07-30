import axios from "axios";
import React, { useContext, useEffect, useState } from "react";
import { AiOutlineStar } from "react-icons/ai";
import "./Review.scss";
import { Context } from "../../utils/context";
import { useNavigate } from "react-router-dom";
import avatar from "../../assets/image-removebg-preview.png";

const Review = ({ productId }) => {
  const { user } = useContext(Context);
  const [listReviews, setListReviews] = useState([]);
  const [review, setReview] = useState("");
  const [rating, setRating] = useState(0);

  const navigate = useNavigate();
  const fetchReviews = async () => {
    axios.get(`/review/get-reviews-of-product/${productId}`).then((res) => {
      setListReviews(res.data);
    });
  };

  useEffect(() => {
    fetchReviews();
  }, [productId]);

  const addReview = () => {
    if (!user) {
      navigate("/login");
    } else {
      if (review) {
        axios
          .post(`/review/create-review`, {
            product_id: productId,
            review_text: review,
          })
          .then(() => {
            fetchReviews();
            setReview("");
          });
      }
    }
  };

  return (
    <div className="review-container">
      <div className="input-review">
        <p>Score</p>
        <div className="score">
          <AiOutlineStar className="star" />
          <AiOutlineStar className="star" />
          <AiOutlineStar className="star" />
          <AiOutlineStar className="star" />
          <AiOutlineStar className="star" />
        </div>
        <textarea
          type="text"
          placeholder="Write a review"
          onChange={(e) => setReview(e.target.value)}
        />
        <button onClick={addReview}>Comment</button>
      </div>
      <div className="list-reviews">
        <h2>List Reviews</h2>

        {listReviews.length > 0 ? (
          <div className="reviews">
            {listReviews.map((review) => (
              <div className="review" key={review.review_id}>
                <div className="info-user">
                  <div className="user-review">
                    <img src={avatar} alt="avatar-user" />
                    <p>{review.full_name}</p>
                  </div>
                  <div className="score">
                    <AiOutlineStar className="star" />
                    <AiOutlineStar className="star" />
                    <AiOutlineStar className="star" />
                    <AiOutlineStar className="star" />
                    <AiOutlineStar className="star" />
                  </div>
                </div>
                <p className="review-text">{review.review_text}</p>
              </div>
            ))}
          </div>
        ) : (
          <p className="text">No reviews</p>
        )}
      </div>
    </div>
  );
};

export default Review;
