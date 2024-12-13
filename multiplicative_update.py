import numpy as np

def multiplicative_update(V, rank, max_iter=100, epsilon=1e-6):
    m, n = V.shape
    W = np.abs(np.random.rand(m, rank))
    H = np.abs(np.random.rand(rank, n))
    errors = []

    for _ in range(max_iter):
        # Update H
        H *= np.dot(W.T, V) / (np.dot(np.dot(W.T, W), H) + epsilon)

        # Update W
        W *= np.dot(V, H.T) / (np.dot(W, np.dot(H, H.T)) + epsilon)

        # Compute Frobenius norm of the error
        error = np.linalg.norm(V - np.dot(W, H), 'fro')
        errors.append(error)

        # Early stopping
        if len(errors) > 1 and abs(errors[-1] - errors[-2]) < epsilon:
            break

    return W, H, errors
