---
title: "Accessing Resources Behind Google IAP using Golang - Pritunl Api Client"
description: ""
lead: ""
date: 2022-08-31T12:44:44-04:00
lastmod: 2022-08-31T12:44:44-04:00
draft: false
url: blog/accessing-resources-behind-iap-pritunl-api-golang
---
This blog post is an example of how to access an HTTPS resource that is sitting behind a google cloud identity aware proxy (IAP) using Golang.

While you can use this for any HTTPS resource behind IAP, this particular example is using the Pritunl VPN's API

I had a bit of trouble writing the Pritunl API client in Golang with their authentication, so if you are here for that, I have you in mind while
writing this.


## So, TL;DR, this blog post is about two things

1. Pritunl API Client in Golang
2. Accessing Something behind GCP IAP


> Note: The same is present in this [Github repo](https://github.com/MansoorMajeed/code-samples/blob/main/golang/pritunl-api-client/main.go) as well, if you are into that instead

## Code

```go

package main

import (
	"context"
	"crypto/hmac"
	"crypto/sha256"
	"encoding/base64"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strconv"
	"strings"
	"time"

	"github.com/google/uuid"
	"google.golang.org/api/idtoken"
)

type vpnUser struct {
	Email    string `json:"email"`
	Disabled bool   `json:"disabled"`
	Name     string `json:"name"`
	Type     string `json:"type"`
}

func main() {
	url := "https://your.http.endpoint.com"

	vpnUsers := []vpnUser{}

	ctx := context.Background()

    // Step 1 : Update the audience with your IAP CLIENT ID.
    // Looks like this : IAP_CLIENT_ID.apps.googleusercontent.com
	audience := "IAP_CLIENT_ID.apps.googleusercontent.com"

	client, err := idtoken.NewClient(ctx, audience)
	if err != nil {
		panic(err)
	}

	method := "GET"
	orgId := "xxxxxxxx"
	path := "/user/" + orgId

    // Step 2 : Obviously, update your api token and secret
	api_token := ""
	api_secret := ""
	now := time.Now()
	auth_timestamp := strconv.FormatInt(now.Unix(), 10)
	uuidString := uuid.New().String()
	// Important : Pritunl API does not like if the uuid string has dashes in them
	auth_nonce := strings.Replace(uuidString, "-", "", -1)

	auth_string_items := []string{api_token, auth_timestamp, auth_nonce, strings.ToUpper(method), path}
	auth_string := strings.Join(auth_string_items[:], "&")

	h := hmac.New(sha256.New, []byte(api_secret))
	h.Write([]byte(auth_string))

	auth_signature := base64.StdEncoding.EncodeToString(h.Sum(nil))

	request, err := http.NewRequest("GET", url+path, nil)

	request.Header.Set("Auth-Token", api_token)
	request.Header.Set("Auth-Timestamp", auth_timestamp)
	request.Header.Set("Auth-Nonce", auth_nonce)
	request.Header.Set("Auth-Signature", auth_signature)

	if err != nil {
		panic(err)
	}
	response, err := client.Do(request)
	if err != nil {
		panic(err)
	}
	defer response.Body.Close()

	fmt.Println(response.StatusCode)

	err = json.NewDecoder(response.Body).Decode(&vpnUsers)
	if err != nil {
		log.Fatal(err)
	}

	for _, u := range vpnUsers {
		if u.Type == "client" {
			log.Printf("%s -> %s \n", u.Email, u.Name)
		}

	}
}

```