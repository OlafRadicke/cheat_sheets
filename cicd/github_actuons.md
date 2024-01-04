GITHUB ACTIONS
==============


BY EXAMPLE
----------

```bash
name: Hugo build test
run-name: ${{ github.actor }} testing build with Hugo.
on:
  push:
    tags:
      - '*'
jobs:
  Explore-GitHub-Actions:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
        with:
          fetch-depth: 2
      # - run: git checkout HEAD^
      - name: Install Hugo
        run: scripts/install_hugo.sh
      - run: echo "This job's status is ${{ job.status }}."
      - name: Run hugo build
        run: |
              ./cache/hugo \
                --source ./ \
                --baseURL  https://olaf-radicke.de \
                --destination public
      - name: Get GitHub Tag Name
        run: |
          echo "Tag name from GITHUB_REF_NAME: $GITHUB_REF_NAME"
          echo "Tag name from github.ref_name: ${{  github.ref_name }}"
      - name: Set up QEMU
        uses: docker/setup-qemu-action@v3
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3
      - name: Login to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}
      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          context: .
          platforms: linux/amd64,linux/arm64
          push: true
          tags: olafradicke/olaf-radicke-de:${{  github.ref_name }}


```

### SEE ALSO

- [Using secrets in GitHub Actions](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions)
- [doku](https://docs.docker.com/build/ci/github-actions/multi-platform/)