;;Server.arc — Server for the Quarry Website
;; Dependencies:
;;  web.arc
;;  srv.arc
;;  
(load "./server/stones/dispatch/dispatch.arc")
(load "./server/stones/dispatch/http.arc")

(defpath /hello (req)  (prs "hello" req!ip "you are visiting" req!path)) ;; for testing
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
      
      (prn "We just made this guy into a mason: " (alref req!args "username"))   
)
(defpath /createstone req)
(defpath /getStone req)
(defpath /info req)


(= hpwfile*   (+ srvdir* "hpw")
   emailfile* (+ srvdir* "emails")
   oidfile*   (+ srvdir* "openids")
   adminfile* (+ srvdir* "admins")
   cookfile*  (+ srvdir* "cooks")
   stone-registry* (+ srvdir* "registy")
)

(def hack ((o port 8080))
  ;;(load-userinfo)
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