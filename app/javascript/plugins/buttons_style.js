import { csrfToken } from "@rails/ujs";

const buttons = document.getElementsByClassName('js-interact');

const illuminate = () => {
  if (buttons) {
    Array.from(buttons).forEach(button => {
      button.addEventListener('click', (e) => {
        e.preventDefault();
        Array.from(buttons).forEach(btn => btn.classList.remove('active'))

        button.classList.add('active')
        /* const csrfToken = document.querySelector("meta[name='csrf-token']").content
        let myHeaders = new Headers({
          'X-CSRF-TOKEN': csrfToken,
        });

        let myInit = {
          method: 'POST',
          headers: myHeaders,
          mode: 'cors',
          cache: 'default',
          body: 'test'
        };

        fetch('/tv_shows/' + button.dataset.id +'/feedbacks', myInit)
        .then(res => */
        /* buttons.forEach(btn => {
          btn.focus()
        }) */
      })
    });
  }
}

export {illuminate}
