# jump-ionic2
Dockerfile (maybe more to come) for creating images used for developing Ionic 2 Portable Web Apps and Angular 2 apps.

See https://blog.saddey.net/2016/07/03/using-docker-to-create-ionic-2-pwa-developer-environment/

Note: This image is targeted towards development, i.e. all-and-everything runs as root.

17-jul-16: Now includes gulp (for building Ionic from sources) and exposes port 5000 (for running node.js)

19-jul-16: Now includes typescript, typings, lite-server, concurrently and angular-cli (to create new artifacts)
in order to support Angular 2 projects, and now exposes ports 3000+3001+3002 (lite-server)

25-jul-16: Now includes support for PhantomJS (used for Karma tests) and exposes
ports 5000 (Node.js), 3000, 3001 and 3002 (gulp, lite-server, …),
8080 (Webpack prod), 9876 (Karma), 8100 and 35729 (Ionic).
