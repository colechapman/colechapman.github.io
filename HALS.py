import numpy as np


def hals(V, rank, max_iter=100, epsilon=1e-6):
    m, n = V.shape
    W = np.abs(np.random.rand(m, rank))
    H = np.abs(np.random.rand(rank, n))
    errors = []

    for _ in range(max_iter):
        # Update H
        for j in range(rank):
            numerator = np.dot(W[:, j].T, V - np.dot(W, H) + np.outer(W[:, j], H[j, :]))
            denominator = np.dot(W[:, j], W[:, j]) + epsilon
            H[j, :] = np.maximum(0, numerator / denominator)

        # Update W
        for j in range(rank):
            numerator = np.dot(V - np.dot(W, H) + np.outer(W[:, j], H[j, :]), H[j, :].T)
            denominator = np.dot(H[j, :], H[j, :].T) + epsilon
            W[:, j] = np.maximum(0, numerator / denominator)

        # Compute Frobenius norm of the error
        error = np.linalg.norm(V - np.dot(W, H), 'fro')
        errors.append(error)

        # Early stopping
        if len(errors) > 1 and abs(errors[-1] - errors[-2]) < epsilon:
            break

    return W, H, errors
