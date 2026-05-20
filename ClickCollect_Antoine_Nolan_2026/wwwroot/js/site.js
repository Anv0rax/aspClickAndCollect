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