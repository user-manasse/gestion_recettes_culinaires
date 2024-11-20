
document.addEventListener('turbo:load', () => {
  const ingredientsDiv = document.getElementById('ingredients');
  const addIngredientButton = document.getElementById('add_ingredient');

  if (addIngredientButton) {
    addIngredientButton.addEventListener('click', (e) => {
      e.preventDefault();
      console.log("Add");
  
      var new_id = new Date().getTime();
      var regexp = new RegExp("new_ingredient", "g");
      var fields = e.target.dataset.fields.replace(regexp, new_id);
      document.getElementById("ingredients").insertAdjacentHTML("beforeend", fields);
    });
  
    ingredientsDiv.addEventListener('click', (e) => {
      if (e.target.classList.contains('remove-fields')) {
        e.preventDefault();

        // Find the closest nested-fields element and set `_destroy` to true
        const ingredientFields = e.target.closest('.nested-fields');
        ingredientFields.querySelector('input[name*="[_destroy]"]').value = 'true';
        ingredientFields.style.display = 'none';
      }
    });
  }

});

document.addEventListener('turbo:load', () => {
  const utensilsDiv = document.getElementById('utensils');
  const addUtensilButton = document.getElementById('add_utensil');

  if (addUtensilButton) {
    addUtensilButton.addEventListener('click', (e) => {
      e.preventDefault();
      console.log("Add utensil");
  
      var new_id = new Date().getTime(); 
      var regexp = new RegExp("new_utensil", "g");
      console.log('Fiels: ', e.target.dataset.fields);
      var fields = e.target.dataset.fields.replace(regexp, new_id);
      utensilsDiv.insertAdjacentHTML("beforeend", fields);
    });
  
    utensilsDiv.addEventListener('click', (e) => {
      if (e.target.classList.contains('remove-utensil-fields')) {
        e.preventDefault();
        
        const utensilFields = e.target.closest('.nested-utensil-fields');
        utensilFields.querySelector('input[name*="[_destroy]"]').value = 'true';
        utensilFields.style.display = 'none';
      }
    });
  }
});

document.addEventListener('turbo:load', () => {
  const stepsDiv = document.getElementById('steps');
  const addStepButton = document.getElementById('add_step');

  if (addStepButton) {
    addStepButton.addEventListener('click', (e) => {
      e.preventDefault();
      console.log("Add step");
  
      var new_id = new Date().getTime();
      var regexp = new RegExp("new_step", "g");
      var fields = e.target.dataset.fields.replace(regexp, new_id);
      stepsDiv.insertAdjacentHTML("beforeend", fields);
    });
  
    stepsDiv.addEventListener('click', (e) => {
      if (e.target.classList.contains('remove-step-fields')) {
        e.preventDefault();

        const stepFields = e.target.closest('.nested-step-fields');
        stepFields.querySelector('input[name*="[_destroy]"]').value = 'true';
        stepFields.style.display = 'none';
      }
    });
  }
});

function previewImage(event) {
  const preview = document.getElementById('image-preview');
  const file = event.target.files[0];
  
  if (file) {
    preview.src = URL.createObjectURL(file);
    preview.classList.remove('hidden');
  } else {
    preview.src = ""; // Remet à zéro le `src` si aucun fichier n'est sélectionné
    preview.classList.add('hidden');
  }
}

// Attach the `previewImage` function to the `onchange` event globaly
window.previewImage = previewImage;
  