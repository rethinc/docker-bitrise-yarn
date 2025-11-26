FROM bitriseio/ubuntu-noble-24.04-bitrise-2025-base:latest

# Remove asdf nodejs plugin if it exists
RUN asdf plugin remove nodejs || true

# Set environment variables
ENV NVM_DIR=/root/.nvm
ENV NODE_VERSION=16.20.2

# Install NVM and Node.js
RUN mkdir $NVM_DIR && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash && \
    . $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm use $NODE_VERSION && \
    nvm alias default $NODE_VERSION

# Update PATH to include Node.js binaries
ENV PATH="$NVM_DIR/versions/node/v${NODE_VERSION}/bin:${PATH}"

# Install Yarn using npm
RUN . $NVM_DIR/nvm.sh && npm install -g yarn

# Verify installations
RUN . $NVM_DIR/nvm.sh && node --version && npm --version && yarn --version
