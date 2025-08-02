ANSIBLE := ansible-playbook
INVENTORY := localhost.ini
KEY := ~/.ssh/DIGITALOCEAN_SSH_KEY
USER := root
PLAYBOOK := playbook.yml

.PHONY: bootstrap deploy ping clean

bootstrap:
	$(ANSIBLE) -i $(INVENTORY) $(PLAYBOOK) -u $(USER) --private-key=$(KEY) -l ubuntu-root

deploy:
	$(ANSIBLE) -i $(INVENTORY) $(PLAYBOOK) -u johnv --private-key=$(KEY) -l ubuntu-user

ping:
	ansible all -i $(INVENTORY) -m ping

debug:
	$(ANSIBLE) -i $(INVENTORY) $(PLAYBOOK) -vvv

clean:
	rm -f *.retry
