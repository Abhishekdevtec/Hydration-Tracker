import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2'

export default class extends Controller {
  static targets = ["subtypeContainer", "customTypeContainer", "symptomsContainer", "temperatureSlider", "form", "temperatureValueC", "temperatureValueF", "temperatureLabel"]

  connect() {
    this.updateTemperatureLabel()
  }

  submitForm(event) {
    event.preventDefault()

    const formData = new FormData(this.formTarget)
    const entries = Object.fromEntries(formData.entries())
    const formElements = this.formTarget.elements;

    const tempC = formElements['beverage_entry[temperature]'].value;
    const tempF = Math.round(tempC * 9 / 5 + 32);
    const tempLabel = this.temperatureLabelTarget.textContent.split('(')[0].trim();

    let confirmationMessage = `
      <div class="text-left space-y-3 text-sm">
        <div class="border-b pb-2">
          <p class="font-semibold text-base">📋 Entry Summary</p>
          <p>📅 <span class="font-medium">Date:</span> ${formElements['beverage_entry[consumed_at_date]'].value || 'Not specified'}</p>
          <p>⏰ <span class="font-medium">Time:</span> ${formElements['beverage_entry[consumed_at_time]'].value || 'Not specified'}</p>
        </div>
        
        <div class="border-b pb-2">
          <p class="font-semibold text-base">🍹 Beverage Details</p>
          <p>▸ <span class="font-medium">Category:</span> ${this.getSelectedText('beverage_entry[beverage_type_id]')}</p>
          ${formElements['beverage_entry[beverage_subtype_id]']?.value ?
        `<p>▸ <span class="font-medium">Type:</span> ${this.getSelectedText('beverage_entry[beverage_subtype_id]')}</p>` : ''}
          ${formElements['beverage_entry[custom_type]']?.value ?
        `<p>▸ <span class="font-medium">Custom Name:</span> ${formElements['beverage_entry[custom_type]'].value}</p>` : ''}
          <p>▸ <span class="font-medium">Quantity:</span> ${formElements['beverage_entry[quantity]'].value || '0'} ${formElements['beverage_entry[unit]'].value || ''}</p>
          <p>▸ <span class="font-medium">Temperature:</span> ${tempLabel} (${tempC}°C / ${tempF}°F)</p>
          ${formData.get('beverage_entry[photo]') && formData.get('beverage_entry[photo]').name ? '<p>▸ 📷 <span class="font-medium">Photo:</span> Attached</p>' : ''}
        </div>
    `;

    // Additions Section
    const additions = this.getSelectedAdditions();
    if (additions.length > 0) {
      confirmationMessage += `
        <div class="border-b pb-2">
          <p class="font-semibold text-base">🧴 Additions</p>
          <p>${additions.map(item => `▸ ${item}`).join('<br>')}</p>
        </div>
      `;
    }

    // General Notes
    if (formElements['beverage_entry[notes]'].value) {
      confirmationMessage += `
        <div class="border-b pb-2">
          <p class="font-semibold text-base">📝 Notes</p>
          <p>${formElements['beverage_entry[notes]'].value}</p>
        </div>
      `;
    }

    // Symptoms Section
    if (entries.has_symptoms === 'yes') {
      confirmationMessage += `
        <div>
          <p class="font-semibold text-base">⚠️ Symptoms</p>
          <p>${this.getSelectedSymptoms().map(item => `▸ ${item}`).join('<br>')}</p>
          <p>▸ <span class="font-medium">Severity:</span> ${entries.symptom_severity || 'Not specified'}</p>
          <p>▸ <span class="font-medium">Timing:</span> ${entries.symptom_timing || 'Not specified'}</p>
          ${entries.symptom_notes ? `<p>▸ <span class="font-medium">Symptom Notes:</span> ${entries.symptom_notes}</p>` : ''}
        </div>
      `;
    }

    if (formData.get('beverage_entry[photo]') && formData.get('beverage_entry[photo]').name) {
      const file = formElements['beverage_entry[photo]'].files[0];
      const previewUrl = URL.createObjectURL(file);

      confirmationMessage += `
        <div class="mt-2">
          <p class="font-medium text-sm">📷 Photo Preview</p>
                <img src="${previewUrl}" class="mt-1 object-contain rounded border" style="max-width: 100%; max-height: 250px;">

        </div>
      `;
    }

    confirmationMessage += `</div>`;

    // Show confirmation dialog
    Swal.fire({
      title: 'Review Your Entry',
      html: confirmationMessage,
      icon: 'info',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, submit',
      cancelButtonText: 'No, make changes',
      focusConfirm: false,
      scrollbarPadding: false
    }).then((result) => {
      if (result.isConfirmed) {
        this.formTarget.submit()
      }
    })
  }

  // Helper to get selected option text
  getSelectedText(selectName) {
    const select = this.formTarget.querySelector(`[name="${selectName}"]`);
    return select?.options[select.selectedIndex]?.text || 'Not specified';
  }

  getSelectedAdditions() {
    return Array.from(this.formTarget.querySelectorAll('[name="beverage_entry[addition_ids][]"]:checked'))
      .map(checkbox => {
        if (checkbox.value === 'other') {
          const otherInput = this.formTarget.querySelector('[name="beverage_entry[other_addition]"]')
          return otherInput ? `Other: ${otherInput.value}` : 'Other'
        }
        return checkbox.nextElementSibling.textContent.trim()
      })
  }

  getSelectedSymptoms() {
    return Array.from(this.formTarget.querySelectorAll('[name="beverage_entry[symptom_ids][]"]:checked'))
      .map(checkbox => {
        if (checkbox.value === 'other') {
          const otherInput = this.formTarget.querySelector('[name="beverage_entry[custom_symptom]"]')
          return otherInput ? `Other: ${otherInput.value}` : 'Other'
        }
        return checkbox.nextElementSibling.textContent.trim()
      })
  }

  updateSubtypes(event) {
    const beverageTypeId = event.target.value
    const subtypeSelect = this.subtypeContainerTarget?.querySelector("select");

    if (beverageTypeId === "-1") {
      // Show custom input, hide subtype dropdown
      this.customTypeContainerTarget.classList.remove("hidden");
      this.subtypeContainerTarget.classList.add("hidden");
      this.subtypeContainerTarget.querySelector("select").value = "";
      setTimeout(() => this.customTypeContainerTarget.focus(), 100);
      subtypeSelect.required = false;
      return;
    }

    // Hide custom input for regular selections
    this.customTypeContainerTarget.classList.add("hidden");

    if (beverageTypeId === "") {
      this.subtypeContainerTarget.classList.add("hidden")
      subtypeSelect.required = false;
    } else {
      fetch(`/beverage_entries/subtypes?beverage_type_id=${beverageTypeId}`)
        .then(response => response.json())
        .then(data => {
          const subtypeSelect = this.subtypeContainerTarget.querySelector("select")
          subtypeSelect.innerHTML = '<option value="">Select a type</option>'

          data.forEach(subtype => {
            const option = document.createElement("option")
            option.value = subtype.id
            option.textContent = subtype.name
            subtypeSelect.appendChild(option)
          })

          subtypeSelect.required = data.length > 0;
          this.subtypeContainerTarget.classList.remove("hidden")
        }
        )
    }
  }

  toggleOtherAddition(event) {
    const otherAdditionContainer = document.getElementById("otherAdditionContainer");
    if (event.target.checked) {
      otherAdditionContainer.classList.remove("hidden");
    } else {
      otherAdditionContainer.classList.add("hidden");
    }
  }

  toggleSymptoms(event) {
    if (event.target.value === "yes") {
      this.symptomsContainerTarget.classList.remove("hidden")
    } else {
      this.symptomsContainerTarget.classList.add("hidden")
    }
  }

  toggleOtherSymptom(event) {
    const otherSymptomContainer = document.getElementById("otherSymptomContainer");
    const otherSymptomCheckbox = document.getElementById("beverage_entry_symptom_other");

    if (otherSymptomCheckbox.checked) {
      otherSymptomContainer.classList.remove("hidden");
    } else {
      otherSymptomContainer.classList.add("hidden");
    }
  }

  setQuantity(event) {
    const quantity = event.target.dataset.quantity
    const unit = event.target.dataset.unit

    this.element.querySelector("#beverage_entry_quantity").value = quantity
    this.element.querySelector("#beverage_entry_unit").value = unit
  }

  // Updates on every slider movement
  updateTemperatureDisplay() {
    const celsius = parseInt(this.temperatureSliderTarget.value);
    const fahrenheit = Math.round(celsius * 9 / 5 + 32);

    this.temperatureValueCTarget.textContent = celsius;
    this.temperatureValueFTarget.textContent = fahrenheit;

    this.updateTemperatureLabel(celsius);
  }

  updateTemperatureLabel(celsius) {
    let label;
    if (celsius <= 0) label = "❄️ Ice Cold (0°C / 32°F)";
    else if (celsius <= 4) label = "🧊 Chilled (4°C / 40°F)";
    else if (celsius <= 10) label = "🥶 Cool (10°C / 50°F)";
    else if (celsius <= 20) label = "🌡️ Room Temperature (20°C / 68°F)";
    else if (celsius <= 50) label = "🔥 Warm (50°C / 122°F)";
    else if (celsius <= 70) label = "☕ Hot (70°C / 158°F)";
    else label = "♨️ Boiling (100°C / 212°F)";

    this.temperatureLabelTarget.textContent = label;
  }

  // Initialize on load
  connect() {
    this.updateTemperatureDisplay();
  }
}
