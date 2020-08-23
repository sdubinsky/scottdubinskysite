function logCall() {
    var body = JSON.stringify({
        'endpoint': window.document.location.pathname
    })
        var request = new XMLHttpRequest();
    request.open('POST', '/logging');
    request.setRequestHeader('Content-Type', 'application/json');
    request.send(body);

}
