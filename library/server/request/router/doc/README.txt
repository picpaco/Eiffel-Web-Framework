This library introduce the notion of router and handler
The Router manages the association between URI,URI template and Handler
The Router is in charge to route/dispatch a request to one of the Handler according to the URI and how the Handler is mapped in the Router.

Common usage

router: REQUEST_ROUTER
hello_handler: REQUEST_HANDLER

create {REQUEST_URI_TEMPLATE_ROUTER} router.make
create {REQUEST_AGENT_HANDLER} hello_handler.make (agent handle_hello)

router.map ("/hello/{name}", hello_handler)
router.map_agent ("/hello/{name}", agent handle_hello)