const output = document.getElementById("output");

function callBackend() {
  fetch("BACKEND_URL/health")
    .then(res => res.text())
    .then(data => output.innerText = "Backend says: " + data)
    .catch(err => output.innerText = err);
}

function callMicroservice() {
  fetch("MICROSERVICE_URL/health")
    .then(res => res.json())
    .then(data => output.innerText = JSON.stringify(data, null, 2))
    .catch(err => output.innerText = err);
}
