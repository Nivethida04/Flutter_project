const mongoose = require('mongoose');

const schema = mongoose.Schema(
  {
    id: {
      type: Number,
      required: true,
    },
    name: {
      type: String,
      required: [true, "Please enter the product name"],
    },
    Quantity: {
      type: Number,
      required: true,
      default: 0,
    },
    price: {
      type: Number,
      required: true,
      default: 0,
    },
  },
  {
    timestamps: true,
  }
);

const Model = mongoose.model("Product", schema);

module.exports = Model;
