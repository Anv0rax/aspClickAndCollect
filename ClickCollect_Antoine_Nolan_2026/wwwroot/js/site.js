function sendSortProduct(select, category) {
    var sort = select.value;
    if (category == '') {
        var url = "?sort=" + sort
    }
    else {
        var url = "?category=" + encodeURIComponent(category) + "&sort=" + sort;
    }

    window.location.href = url;
}