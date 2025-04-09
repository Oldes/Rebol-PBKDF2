REBOL [
    title: "SCRAM Authentication Exchange Test"
    needs: 3.11.0
]

import %scram.reb

;; https://datatracker.ietf.org/doc/html/rfc5802#section-5
state: context [
    ;; input values...
    password: "pencil"
    salt: debase "QSXCR+Q6sek8bf92" 64
    iterations: 4096
    method: 'sha1
    gs2-header: "n,," ;;<-- "biws" as base64 (used in the client-final-message-without-proof)
    client-first-message-bare: "n=user,r=fyko+d2lbbFgONRv9qkxdawL"
    server-first-message:      "r=fyko+d2lbbFgONRv9qkxdawL3rfcNHYJY1ZVvWVs7j,s=QSXCR+Q6sek8bf92,i=4096"
    client-final-message-without-proof: "c=biws,r=fyko+d2lbbFgONRv9qkxdawL3rfcNHYJY1ZVvWVs7j"
    ;; output values...
    SaltedPassword:
    ClientKey:
    ServerKey:
    StoredKey:
    AuthMessage:
    ClientSignature:
    ServerSignature:
    ClientProof: none
]

;; Compute output values using SCRAM and input values in the state object
scram :state
;; Display all values in the state object...
? state
print ["ClientProof:" state/ClientProof]
print ["   Expected:" result1: debase "v0X8v3Bz2T0CJGbJQyF0X+HI4Ts=" 64]
print ["ServerProof:" state/ServerSignature]
print ["   Expected:" result2: debase "rmF9pqV8S7suAoZWja4dJRkFsKQ=" 64]

if any [
    result1 <> state/ClientProof
    result2 <> state/ServerSignature
][  quit/return 1 ]