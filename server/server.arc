;;Server.arc — Server for the Quarry Website
;; Dependencies:
;;  web.arc
;;  srv.arc
;;  
(load "./server/stones/dispatch/dispatch.arc")
(load "./server/stones/dispatch/http.arc")

(= userfile* (+ srvdir* "userfile"))

(def load-users ()
  (= user-info (safe-load-table userfile*) )
)

;;users={ 
;;  kinnard: { password: 'secret', email: 'kinnard@bitbox.mx' },
;;  kartik: { password: 'secretsecret', email: 'ak@gmail.com' }
;;}
(deftem newuser username (password nil email nil))
(def create-acct (username password email)
  (w/appendfile uf userfile* 
    (temstore 'newuser '('username username '('password password 'email email)) uf)
))

(def disable-acct (user)
  (set-pw user (rand-string 20))
  (logout-user user))

(def set-pw (user pw)
"Updates password for 'user'."
  (= (hpasswords* user) (and pw (shash pw)))
  (save-table hpasswords* hpwfile*))

(def set-email (user email)
  (= emails*.user email)
  (save-table emails* emailfile*))

(defpath /hello (req)  (prn "<form method='POST' action='/createmason'><input type='text' name=username></input> </form>")) ;; for testing
;;Website
(defpath || req (pr "welcome welcome"))
(defpath /documentation req)
(defpath /stones req)
(defpath /masons req)

(def lookupStone (stone-name)(
  ;;if stone in stones return stone-info else pr "Sorry couldn't find that stone"
  )
) 
(def findMason (mason-name)(
  ;;if mason in masons return mason else pr "Sorry couldn't find that mason"
  )
  
)
(def getStone (stone-name)(
  ;;if stone in stones return stone-info else pr "Sorry couldn't find that stone"
  ;;++ stone-info.downloads
  )
)

;;API
(defpath /createmason (req)
      (create-acct (alref req!args "username") (alref req!args "password") (alref req!args "email"))
      (pr "Welcome to the lodge " (alref req!args "username") "!")   
)
(defpath /createstone req)
(defpath /getStone req)
(defpath /info req)



;;(= hpwfile*   (+ srvdir* "hpw")
;;   emailfile* (+ srvdir* "emails")
;;   oidfile*   (+ srvdir* "openids")
;;   adminfile* (+ srvdir* "admins")
;;   cookfile*  (+ srvdir* "cooks")
;;   stone-registry* (+ srvdir* "registy")
;;)

(def hack ((o port 8080))
  (load-users)
  ;;(load-stones)
  (prn "quarry Server up and running")
  (start-httpd port)
)

;;(def load-userinfo ()
;;  (= hpasswords*   (safe-load-table hpwfile*)
;;     emails*       (safe-load-table emailfile*)
;;     openids*      (safe-load-table oidfile*)
;;     admins*       (map string (errsafe (readfile adminfile*)))
;;     cookie->user* (safe-load-table cookfile*))
;;  (maptable (fn (k v) (= (user->cookie* v) k))
;;            cookie->user*))
;;(def load-stones ()
;;    (= stones* (safe-load-table stone-registry*))
;;    
;;)




(hack 9999)