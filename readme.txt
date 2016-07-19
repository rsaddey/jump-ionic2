For Ionic2 projects:
1. Run ineractively and map the /projects volume to your host, e.g. docker run -it -v /Users/<host_path>:/projects <image>
2. ionic start myFirstIonic2App sidemenu --v2 --ts ### --ts selects TypeScript
3. cd myFirstIonic2App
4. ionic serve --all
5. Navigate to http://localhost:8100/

For Angular2 projects:
1. typings init
2. npm install --unsafe-perm
3. npm start
4. Navigate to http://localhost:3000/
