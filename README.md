# clientForSpotifyTTP
My submission for Spotify Fellowship via NYC Tech Talent Pipeline's coding challenge.

The Client is in Swift 3 format.

My heroku server for the challenge is found here: https://serverforspotify.herokuapp.com/people

Client performs the following operations:

|GET, DELETE (edit in row)|POST|GET/:id, PUT, DELETE|
|:---:|:---:|:---:|
| <img src="https://github.com/viczhong/clientForSpotifyTTP/blob/master/Screen1.png" width="250"> | <img src="https://github.com/viczhong/clientForSpotifyTTP/blob/master/Screen3.png" width="250"> | <img src="https://github.com/viczhong/clientForSpotifyTTP/blob/master/Screen2.png" width="250"> |
| Home Screen | Add Person Screen | Edit Person Screen |

---

Client: The client makes requests via session data tasks for the GET, GET/:id, POST, PUT, and DELETE operations to the specified endpoint. For GET and GET/:id, they query the server for either all entries or the specific unique ID, respectively.

For the POST and PUT, it appends the JSON serialized message body of the request to the data task of the HTTP URL session. For DELETE, it just sends a DELETE request to delete that entry.

---

RESTful server: As I am unfamiliar with setting up servers, I mostly followed a tutorial for a framework and database program I am unfamiliar with: Angular.js and MongoDB, respectively. I mostly kept things basic, except for the installation of a module that allows for auto-incremental sequencing, which is functional not out-of-the-box with MongoDB.

I implemented GET, GET/:id, POST, PUT, and DELETE operations, to the way I am accustomed and in its simplest form. I believe it should fulfill all of the requirements of the challenge.

---

To complete this question you will need to write both a client and a server. We are agnostic to how you design the client (mobile web, iOS, Android, desktop web) but it will need to be able to make HTTP requests to a specific endpoints.  The server you create will also need to be able to respond to HTTP requests to specific endpoints.  It is not important what language or framework you use to build your server.

The client should do the following in order
1. Make a GET request to /people
2. Make a POST request to /people
3. Please make the person object have the following attributes: id, name : “Sean”, favoriteCity : “New York”
4. Make a GET request to retrieve the object created in the previous request
5. Make a PUT request to /people and modify the attribute city to be “Brooklyn”
6. Make a GET request to /people/1
7. Make a DELETE request to /people/1
8. Make a GET request to /people

Using restful principles, decide how the server should handle each request including responding with the appropriate JSON.  We are intentionally being vague about what exactly each request should do on the server.  We want you to use your best guess as to how other programmers might expect your API to behave.

Please deploy your server to heroku and give us the address.  Please give us instructions on how your client will make the required requests to your server.
