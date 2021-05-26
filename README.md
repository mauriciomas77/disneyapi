## Disney API

Stack usado

- Devise (authenticate)
- JWT (JSON Web Token)
- FastJsonApi Serializer


## Nota: Los datos de la BASE de datos no necesariamente son reales. La API se desarrolla a fines didácticos
![3513ecc960b9ba071bcde039205db3e8.png](:/94adc277f4cc42528a6c170b53cf5628)
## Endpoints

* Registro
```
/register  {POST}
```

Para probar el endpoint usted puede escribir el siguiente código en el navegador:
```
fetch("https://apidisney.herokuapp.com/signup", {
  method: "post",
  headers: {
    "Content-Type": "application/json",
  },
  body: JSON.stringify({
    user: {
      email: "test@test.com",
      password: "password",
    },
  }),
})
.then((res) => {
  if (res.ok) {
    console.log(res.headers.get("Authorization"));
    localStorage.setItem("token", res.headers.get("Authorization"));
    return res.json();
  } else {
    throw new Error(res);
  }
})
.then((json) => console.dir(json))
.catch((err) => console.error(err));
```

Luego de de hacer el request obtendrá un objeto con la información del usuario registrado y el token. Este último tiene una duración de 30 minutos (opción configurable vía JWT)


* Login

```
/login {POST}
```
Es posible hacer el login con un request como el siguiente:
```
fetch("https://apidisney.herokuapp.com/login", {
  method: "post",
  headers: {
    "Content-Type": "application/json",
  },
  body: JSON.stringify({
    user: {
      email: "test@test.com",
      password: "password",
    },
  }),
})
.then((res) => {
  if (res.ok) {
    console.log(res.headers.get("Authorization"));
    localStorage.setItem("token", res.headers.get("Authorization"));
    return res.json();
  } else {
    throw new Error(res);
  }
})
.then((json) => console.dir(json))
.catch((err) => console.error(err));
```
Este endpoint le devolverá el token necesario para hacer el request de personajes
* Personajes

```
/characters
```
Para poder acceder a este endpoint debe incluir el token activo en el header del request
```
fetch("https://apidisney.herokuapp.com/characters", {
  headers: {
    "Content-Type": "application/json",
    Authorization: localStorage.getItem("token"),
  },
})
.then((res) => {
  if (res.ok) {
    console.log(res.headers.get("Authorization"));
    localStorage.setItem("token", res.headers.get("Authorization"));
    return res.json();
  } else {
    throw new Error(res);
  }
})
.then((json) => console.dir(json))
.catch((err) => console.error(err));
```
El endpoint devolverá un objeto con todos los personajes de la base de datos y la llave include con todas las películas y generos asociados.

```
/movies
```
Para poder acceder a este endpoint debe incluir el token activo en el header del request
```
fetch("https://apidisney.herokuapp.com/movies", {
  headers: {
    "Content-Type": "application/json",
    Authorization: localStorage.getItem("token"),
  },
})
```

## Otros endpoints disponibles

GET /characters?name=nombre
GET /characters?age=edad
GET /characters?movies=idMovie

GET /movies?name=nombre
GET /movies?genre=idGenero
GET /movies?order=ASC|DESC
