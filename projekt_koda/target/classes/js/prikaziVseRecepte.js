function fetchRecipes(category = null) {
    const url = 'http://localhost:8081/recepti';

    fetch(url)
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            console.log("Fetched recipes:", data); // Debugging
            const receptiContainer = document.getElementById('recepti-container');
            const messageContainer = document.getElementById('message-container');
            receptiContainer.innerHTML = '';

            if (!data || data.length === 0) {
                messageContainer.style.display = 'block';
                return;
            }

            messageContainer.style.display = 'none';
            data.forEach(recept => {
                const cardContainer = document.createElement('div');
                cardContainer.classList.add('col', 'mb-5', 'card-container');

                cardContainer.innerHTML = `
                <div class="card h-100 shadow-sm border-0 position-relative">
                    <img class="card-img-top" src="${recept.slika}" alt="${recept.naziv}" onerror="this.onerror=null;this.src='assets/img/placeholder.jpg';" />
                    <div class="card-body p-4">
                        <h5 class="fw-bolder">${recept.naziv}</h5>
                        <p><i class="bi bi-clock"></i> ${recept.pripravaMinute} min</p>
                        <p><i class="bi bi-people"></i> ${recept.steviloOseb} osebe</p>
                    </div>
                </div>`;
                receptiContainer.appendChild(cardContainer);
            });
        })
        .catch(error => {
            console.error('Error fetching recipes:', error);
            document.getElementById('recepti-container').innerHTML = '<p>Error loading recipes. Please try again later.</p>';
        });
}
