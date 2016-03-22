;;Server.arc — Server for the Quarry Website
;; Dependencies:
;;  web.arc
;;  srv.arc
;;  
(require "server/stones/app.arc")
(require "server/stones/srv.arc")

(defop || req (pr "welcome welcome"))
;;(defop masons)
;;(defop stones)

(defop createmason req
    handle-post

    )
(defop createstone req)
(defop getStone req)
(defop info req)
(defop documentation req)

(= hpwfile*   (+ srvdir* "hpw")
   emailfile* (+ srvdir* "emails")
   oidfile*   (+ srvdir* "openids")
   adminfile* (+ srvdir* "admins")
   cookfile*  (+ srvdir* "cooks")
   stone-registry* (+ srvdir* "registy")
)

(def hack ((o port 8080))
  (load-userinfo)
  (load-stones)
  (serve port)
)

(def load-userinfo ()
  (= hpasswords*   (safe-load-table hpwfile*)
     emails*       (safe-load-table emailfile*)
     openids*      (safe-load-table oidfile*)
     admins*       (map string (errsafe (readfile adminfile*)))
     cookie->user* (safe-load-table cookfile*))
  (maptable (fn (k v) (= (user->cookie* v) k))
            cookie->user*))
(def load-stones ()
    (= stones* (safe-load-table stone-registry*))
    
)
(hack 9999)