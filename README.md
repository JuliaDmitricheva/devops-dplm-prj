##### В процессе выполнения проекта необходимо описать в Git:
* конфигурации серверов в облачной инфраструктуре (IaC);
* пайплайны для сборки и деплоя исходного приложения.
* конфигурации мониторинга и сборку логов этого приложения.

###### Week 1
Нам нужно создать три сервера (Ya cloud) (описываем с помощью Terraform):
* два сервера в одном кластере Kubernetes: 1 master и 1 app;
* сервер srv для инструментов мониторинга, логгирования и сборок контейнеров.
Автоматизируем установку с помощью Ansible.
