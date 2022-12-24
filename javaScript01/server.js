'use strict';

const Hapi = require('hapi');

const server = Hapi.server({ 
    port: 3000,
    host: 'localhost'
});

server.route({
    method: 'GET',
    path: '/',
    handler: (request, h) => {
        return 'Hello, CSYE 7220'; 
    }
});

server.route({
    method: 'GET',
    path: '/{name}',
    handler: (request, h) => {
        return 'Hello, ' + encodeURIComponent(request.params.name) + ', this is CSYE 7220!'; 
    }
});

// const init = async () => {
//     await server.start();
//     console.log(`Server running at: ${server.info.uri}`); 
// };

const init = async () => {
    await server.register(require('inert'));
    server.route({
    method: 'GET',
    path: '/song',
    handler: (request, h) => {
        return h.file('./public/mysong.html');
    }
});
await server.start();
console.log(`Server running at: ${server.info.uri}`); };

process.on('unhandledRejection', (err) => {
    console.log(err);
    process.exit(1); 
});

init();