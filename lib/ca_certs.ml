let rec detect_list =
  let open Lwt in
  function
  | [] -> return_none
  | path :: paths ->
      Lwt_unix.file_exists path >>= fun exists ->
      if exists then return_some (`Ca_file path) else detect_list paths

let locations =
  [
    (* Debian/Ubuntu/Gentoo etc.*)
    "/etc/ssl/certs/ca-certificates.crt";
    (* Fedora/RHEL 6 *)
    "/etc/pki/tls/certs/ca-bundle.crt";
    (* OpenSUSE *)
    "/etc/ssl/ca-bundle.pem";
    (* OpenELEC *)
    "/etc/pki/tls/cacert.pem";
    (* CentOS/RHEL 7 *)
    "/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem";
    (* Alpine Linux *)
    "/etc/ssl/cert.pem";
  ]

let detect () = detect_list locations
