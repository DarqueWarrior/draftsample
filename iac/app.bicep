// Use this file to declare your application and the relationships between its services
// using Radius.

// You can declare parameters to pass in resources created by infra.bicep or infra.dev.bicep
// param database_name string 

resource app 'radius.dev/Application@v1alpha3' = {
  name: 'draftsample'

  // Creates a container to run the radius.azurecr.io/webapptutorial-todoapp
  // image
  resource demo 'Container' = {
    name: 'demo'
    properties: {
      container: {
        image: 'acrxk2ymx64wmmh4.azurecr.io/draftsample:707b80ba3c8b9f7a31d40751d305eebdf56dfc29'
        ports: {
          web: {
            containerPort: 5020
            provides: web.id
          }
        }
      }
    }
  }

  // Create a route to accept HTTP traffic from the internet.
  // Remove the 'gateway' section to use as an internal route.
  resource web 'HttpRoute' = {
    name: 'web'
    properties: {
      gateway: {
        hostname: '*'
      }
    }
  }
}
