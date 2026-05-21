function sendSortProduct(select, category, search) {
    var sort = select.value;

    if (search == '') {
        if (category == '') {
            var url = "?sort=" + sort
        }
        else {
            var url = "?category=" + encodeURIComponent(category) + "&sort=" + sort;
        }
    }
    else {
        var url = "?search=" + encodeURIComponent(search) + "&category=" + encodeURIComponent(category) + "&sort=" + sort;
    }

    window.location.href = url;
}

function changePriceForBoxes(input, price) {
    var display = document.getElementById("final_price_cart_display");
    var total = document.getElementById("final_price_cart");
    var price = parseFloat(price.toString().replace(",", "."));
    var boxes = parseFloat(input.value);
    var finalPrice = parseFloat(total.innerHTML.replace(",", ".")) - (boxes * price);
    if (!isNaN(finalPrice)) {
        display.innerHTML = finalPrice.toFixed(2);
    }
}