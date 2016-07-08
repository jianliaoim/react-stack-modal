
React Stack Modal
----

Demo http://ui.talk.ai/react-stack-modal

### Design Purpose

Ideas behind this component: [New modal built for React called react-stack-modal](https://hashnode.com/post/new-modal-built-for-react-called-react-stack-modal-cik1bmmif00054c53wtyxlk9u)

State of modals and popovers are managed inside the store, so Controller will have full access to modals and it makes sophisticated logics possible. And the cost is we need quite some boilerplate code.

### Usage

This component is based on [`actions-recorder`](https://github.com/jianliaoim/actions-recorder).

```bash
npm i --save react-stack-modal
```

Steps to use this modal:

* Setup `actions-recorder`
* Setup `modalStack: []` in store as the default modal list
* Connect actions `modal/add modal/remove modal/content-click` to `updater/modal.coffee`
* Mount `ModalStack` in component tree and wire up events
* Pick what you need in `main.css` and add in your project

Browse [`app/`][app] folder for details. Well this is a library designed for heavy use of modals and popovers. It may be over complicated.

[app]: https://github.com/jianliaoim/react-stack-modal/tree/master/app

### Troubleshooting

* `autoFocus: true` may break entering transition, add `requestAnimationFrame` to bypass.

### Develop

Project template:

https://github.com/teambition/coffee-webpack-starter

### License

MIT
