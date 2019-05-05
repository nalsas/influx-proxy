// Copyright 2016 Eleme. All rights reserved.
// Use of this source code is governed by a MIT
// license that can be found in the LICENSE file.

package backend

import "net/http"

type Context struct {
	req *http.Request
}

type Querier interface {
	Query(w http.ResponseWriter, req *http.Request) (err error)
}

type BackendAPI interface {
	Querier
	GetUrl() (url string)
	IsActive() (b bool)
	IsWriteOnly() (b bool)
	Ping() (version string, err error)
	GetZone() (zone string)
	Write(p []byte) (err error)
	Close() (err error)
	SetContext(ctx Context) (err error)
}
