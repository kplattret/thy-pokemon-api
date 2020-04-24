FORMAT: 1A

# Thy Pokemon API

This API allows you to get a description of a given Pokemon in Shakespearean English.

## Errors

- `404 Not Found` – The requested resource is not available, most likely because it does not exist.
- `429 Too Many Requests` – You are being rate-limited. You may try again later.
- `500 Internal Server Error` – Something went wrong on the server; it's not your fault. You could
    try the request again and it might succeed.

All the error bodies will include the following JSON payload:

```json
{
  "errors": {
    "detail": "Not Found"
  }
}
```

# Endpoint(s)

All available endpoints.

## Retrieve a Pokemon description [/pokemon/:name] [GET]

Given a `name` parameter which is an existing Pokemon name, this will return a description of their
species in Shakespearean English.

+ Request

  + Headers

    `Content-Type: application/json`
    `Accept: application/json`

  + Body

    ```json
    {
      "name": "charizard"
    }
    ```

+ Response 200 (application/json)

  + Headers
  
    `Content-Type: application/json`

  + Body

    ```json
    {
      "name": "charizard",
      "description": "Charizard flies 'round the sky in search of powerful opponents. 't breathes
        fire of such most wondrous heat yond 't melts aught. However, 't nev'r turns its fiery
        breath on any opponent weaker than itself."
    }
    ```
