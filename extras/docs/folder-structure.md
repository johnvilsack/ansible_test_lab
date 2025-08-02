* [REPO]
  * [docs]
  * [host]
    * [.templates]
      * [<server_type>]
        * defaults.yml
        * docker-compose.yml.j2
        * Dockerfile.j2
        * [scripts]
          * entrypoint.sh
          * init.sh
    * [volumes]
      * [<server_name>]
        * [<server volumes>]
    * [<server_name>]
      * docker-compose.yml
      * Dockerfile
    * build_host.yml
  * MAIN PLAYBOOK GOES HERE
