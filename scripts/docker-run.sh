#!/bin/bash
set -e
ACTION=${1:-up}
case ${ACTION} in
    up)
        echo "Starting services..."
        docker-compose up -d
        echo ""
        echo "✅ Services started!"
        docker-compose ps
        ;;
    down)
        echo "Stopping services..."
        docker-compose down
        ;;
    logs)
        docker-compose logs -f
        ;;
    *)
        echo "Usage: $0 [up|down|logs]"
        exit 1
        ;;
esac
