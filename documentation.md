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

## Pokemon description [/pokemon/:name]

The description of a Pekemon species, in Shakespearean English.

+ Parameters

  + name: "charizard" – A unique identifier of the Pokemon; their name in lowercase.

## Retrieve a Pokemon description [GET]

+ Request

  + Headers

    `Content-Type: application/json`
    `Accept: application/json`

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
